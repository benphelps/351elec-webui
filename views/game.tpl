<%
    include('_header.tpl', title=game["name"], nav=dict(zip(
        ('Systems', system_name, game["name"]),
        (
            '/',
            '/system/%s' % system,
            '/system/%s/%s' % (system, game_id)
        )
    )))
%>
    <div x-data="{ show_modal: false, modal_src: '' }" @keydown.escape="show_modal = false"  class="mt-3 grid grid-cols-1 gap-5 lg:gap-6 lg:grid-cols-2">
        <div
            class="fixed inset-0 z-30 flex items-center justify-center overflow-auto bg-slate-900 bg-opacity-80"
            x-show="show_modal"
        >
            <div
                class="max-w-3xl px-6 py-4 mx-auto text-left bg-white dark:bg-slate-700 rounded shadow-lg"
                @click.away="show_modal = false"
                x-transition:enter="motion-safe:ease-out duration-300"
                x-transition:enter-start="opacity-0 scale-90"
                x-transition:enter-end="opacity-100 scale-100"
            >
                <div class="flex items-center justify-center checkers">
                    <img :src="modal_src" alt="Screenshot">
                </div>
            </div>
        </div>

        <div class="bg-white dark:bg-slate-700 shadow dark:shadow-none overflow-hidden sm:rounded-lg">
            <div class="px-3 py-3 sm:px-3 bg-slate-700 dark:bg-slate-800 text-white">
                <h3 class="text-lg leading-6 font-medium">
                    {{ game["name"] }}
                </h3>
                <p class="mt-1 max-w-2xl text-sm opacity-40">
                    {{ game["path"] }}
                </p>
            </div>
            <div class="border-t border-slate-200 dark:border-slate-800 px-3 py-3 sm:p-0 dark:text-white">
                <dl class="sm:divide-y sm:divide-slate-200 sm:dark:divide-slate-800">
                    <div class="py-4 px-4 sm:grid sm:grid-cols-3 sm:gap-4" x-data="texts()">
                        <dt class="text-sm font-medium text-slate-500 dark:text-white">
                            Description
                        </dt>
                        <dd class="mt-1 text-sm text-slate-900 sm:mt-0 sm:col-span-2 dark:text-slate-300">
                            <template x-for="(text, index) in texts">
                                <div>
                                    <p class="line-clamp" x-text="text" x-init="$nextTick(() => { setTruncate(index, $el) })"></p>
                                    <template x-if="truncatable[index]">
                                        <div>
                                            <button class="mt-2 underline text-slate-600 dark:text-slate-200" @click="event.target.parentNode.parentNode.querySelector('p').classList.remove('line-clamp'); truncated[index] = false;" x-show="truncated[index]">Read more...</button>
                                            <button class="mt-2 underline text-slate-600 dark:text-slate-200" @click="event.target.parentNode.parentNode.querySelector('p').classList.add('line-clamp'); truncated[index] = true;" x-show="!truncated[index]">Read less...</button>
                                        </div>
                                    </template>
                                </div>
                            </template>
                        </dd>
                    </div>
                    % if game["rating"]:
                        <div class="py-4 px-4 sm:grid sm:grid-cols-3 sm:gap-4">
                            <dt class="text-sm font-medium text-slate-500 dark:text-white">
                                Rating
                            </dt>
                            <dd class="mt-1 text-sm text-slate-900 sm:mt-0 sm:col-span-2 dark:text-slate-300">
                                <div class="stars" style="--rating: {{ game["rating"] * 5 }};"></div>
                                <span class="font-medium text-sm">{{ game["rating"] * 5 }} / 5</span>
                            </dd>
                        </div>
                    % end
                    <div class="py-4 px-4 sm:grid sm:grid-cols-3 sm:gap-4">
                        <dt class="text-sm font-medium text-slate-500 dark:text-white">
                            Release Date
                        </dt>
                        <dd class="mt-1 text-sm text-slate-900 sm:mt-0 sm:col-span-2 dark:text-slate-300">
                            {{ game["releasedate"] or "Unknown" }}
                        </dd>
                    </div>
                    <div class="py-4 px-4 sm:grid sm:grid-cols-3 sm:gap-4">
                        <dt class="text-sm font-medium text-slate-500 dark:text-white">
                            Developer
                        </dt>
                        <dd class="mt-1 text-sm text-slate-900 sm:mt-0 sm:col-span-2 dark:text-slate-300">
                            {{ game["developer"] or "Unknown" }}
                        </dd>
                    </div>
                    <div class="py-4 px-4 sm:grid sm:grid-cols-3 sm:gap-4">
                        <dt class="text-sm font-medium text-slate-500 dark:text-white">
                            Publisher
                        </dt>
                        <dd class="mt-1 text-sm text-slate-900 sm:mt-0 sm:col-span-2 dark:text-slate-300">
                            {{ game["publisher"] or "Unknown" }}
                        </dd>
                    </div>
                    <div class="py-4 px-4 sm:grid sm:grid-cols-3 sm:gap-4">
                        <dt class="text-sm font-medium text-slate-500 dark:text-white">
                            Players
                        </dt>
                        <dd class="mt-1 text-sm text-slate-900 sm:mt-0 sm:col-span-2 dark:text-slate-300">
                            {{ game["players"] or "Unknown" }}
                        </dd>
                    </div>

                    <div class="py-4 px-4">
                        <span class="text-sm font-medium text-slate-500 dark:text-white block mb-1">ROMs</span>
                        <ul role="list" class="border border-slate-200 dark:border-slate-800 rounded-md divide-y divide-slate-200">
                            <li class="pl-3 pr-4 py-3 flex items-center justify-between text-sm">
                                <div class="w-0 flex-1 flex items-center">
                                    <i class="far fa-sd-card"></i>
                                    <span class="ml-2 flex-1 w-0 truncate">
                                        {{ game["path"] }} <span class="text-xs opacity-30">{{game["size"] }}</span>
                                    </span>
                                </div>
                                <div class="ml-4 flex-shrink-0">
                                    <a href="/rom/{{ system }}/{{ game["path"] }}" class="font-medium underline text-slate-600 hover:text-slate-500 dark:text-slate-200 dark:hover:text-slate-300">
                                        <i class="far fa-download"></i>
                                    </a>
                                </div>
                            </li>
                        </ul>

                        % if len(game["saves"]) > 0:
                            <span class="text-sm font-medium text-slate-500 dark:text-white block mb-1 mt-3">Saves</span>
                            <ul role="list" class="border border-slate-200 dark:border-slate-800 rounded-md divide-y divide-slate-200 mb-3">
                                % for save in game["saves"]:
                                    <li class="pl-3 pr-4 py-3 flex items-center justify-between text-sm">
                                        <div class="w-0 flex-1 flex items-center">
                                            <i class="far fa-save"></i>
                                            <span class="ml-2 flex-1 w-0 truncate">
                                                {{ save }}
                                            </span>
                                        </div>
                                        <div class="ml-4 flex-shrink-0">
                                            <a @click="show_modal = true; modal_src = '/snapshot/{{ system }}/{{ save }}';" class="font-medium underline text-slate-600 hover:text-slate-500 dark:text-slate-200 dark:hover:text-slate-300 cursor-pointer pr-1"><i class="fas fa-eye"></i></a>
                                            <a href="/savestate/{{ system }}/{{ save }}" class="font-medium underline text-slate-600 hover:text-slate-500 dark:text-slate-200 dark:hover:text-slate-300"><i class="far fa-download"></i></a>
                                        </div>
                                    </li>
                                % end
                            </ul>
                        % end

                        % if len(game["screenshots"]) > 0:
                            <span class="text-sm font-medium text-slate-500 dark:text-white block mb-1">Screenshots</span>
                            <ul role="list" class="border border-slate-200 dark:border-slate-800 rounded-md divide-y divide-slate-200">
                                % for screenshot in game["screenshots"]:
                                    <li class="pl-3 pr-4 py-3 flex items-center justify-between text-sm">
                                        <div class="w-0 flex-1 flex items-center">
                                            <i class="far fa-image"></i>
                                            <span class="ml-2 flex-1 w-0 truncate">
                                                {{ screenshot }}
                                            </span>
                                        </div>
                                        <div class="ml-4 flex-shrink-0">
                                            <a @click="show_modal = true; modal_src = '/screenshots/{{ screenshot }}';" class="font-medium underline text-slate-600 hover:text-slate-500 dark:text-slate-200 dark:hover:text-slate-300 cursor-pointer"><i class="fas fa-eye"></i></a>
                                        </div>
                                    </li>
                                % end
                            </ul>
                        % end
                    </div>
                </dl>
            </div>
        </div>

        <ul role="list" class="grid grid-cols-1 md:grid-cols-2 gap-0 mx-auto">
            % if game["marquee"]:
                <li class="relative pr-3 pb-3 flex flex-col">
                    <div class="flex checkers grow group block w-full aspect-w-10 aspect-h-7 rounded-lg bg-slate-100 overflow-hidden cursor-pointer">
                        <img @click="show_modal = true; modal_src = $event.target.src;" src="/image/{{ system }}/{{ game["marquee"] }}" alt="marquee" class="self-center w-full p-3">
                    </div>
                    <p class="mt-2 block text-sm font-medium text-slate-900 dark:text-slate-300 truncate pointer-events-none">Marquee</p>
                    <p class="block text-xs font-medium text-slate-500 dark:text-slate-500 pointer-events-none truncate">{{ game["marquee"] }}</p>
                </li>
            % end
            % if game["image"]:
                <li class="relative pr-3 pb-3 flex flex-col">
                    <div class="flex checkers grow group block w-full aspect-w-10 aspect-h-7 rounded-lg bg-slate-100 overflow-hidden cursor-pointer">
                        <img @click="show_modal = true; modal_src = $event.target.src;" src="/image/{{ system }}/{{ game["image"] }}" alt="image" class="self-center w-full">
                    </div>
                    <p class="mt-2 block text-sm font-medium text-slate-900 dark:text-slate-300 truncate pointer-events-none">Image</p>
                    <p class="block text-xs font-medium text-slate-500 dark:text-slate-500 pointer-events-none truncate">{{ game["image"] }}</p>
                </li>
            % end
            % if game["thumbnail"]:
                <li class="relative pr-3 pb-3 flex flex-col">
                    <div class="flex checkers grow group block w-full aspect-w-10 aspect-h-7 rounded-lg bg-slate-100 overflow-hidden cursor-pointer">
                        <img @click="show_modal = true; modal_src = $event.target.src;" src="/image/{{ system }}/{{ game["thumbnail"] }}" alt="thumbnail" class="self-center w-full">
                    </div>
                    <p class="mt-2 block text-sm font-medium text-slate-900 dark:text-slate-300 truncate pointer-events-none">Thumbnail</p>
                    <p class="block text-xs font-medium text-slate-500 dark:text-slate-500 pointer-events-none truncate">{{ game["thumbnail"] }}</p>
                </li>
            % end
            % if game["video"]:
                <li class="relative pr-3 pb-3 flex flex-col">
                    <div class="flex checkers grow group block w-full aspect-w-10 aspect-h-7 rounded-lg bg-slate-100 overflow-hidden">
                        <video width="100%" class="self-center w-full" loop autoplay muted>
                            <source src="/video/{{ system }}/{{ game["video"] }}" type="video/mp4">
                        </video>
                    </div>
                    <p class="mt-2 block text-sm font-medium text-slate-900 dark:text-slate-300 truncate pointer-events-none">Video</p>
                    <p class="block text-xs font-medium text-slate-500 dark:text-slate-500 pointer-events-none truncate">{{ game["video"] }}</p>
                </li>
            % end
        </ul>
    </div>

    <script>
        function htmlDecode(input) {
            var doc = new DOMParser().parseFromString(input, "text/html");
            return doc.documentElement.textContent;
        }

        function texts() {
            return {
                truncated: [false],
                truncatable: [false],
                texts: [
                    htmlDecode(`{{ game["desc"] }}`),
                ],
                setTruncate(index, element) {
                    if (element.offsetHeight < element.scrollHeight ||
                        element.offsetWidth < element.scrollWidth) {
                        this.truncated[index] = true;
                        this.truncatable[index] = true;
                    } else {
                        this.truncated[index] = false;
                        this.truncatable[index] = false;
                    }
                }
            }
        }
    </script>
% include('_footer.tpl')
